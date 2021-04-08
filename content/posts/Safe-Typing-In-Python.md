+++
Title = "Lessons Learned using MyPy in Production"
date = 2021-04-07
description = "Lessons learned used MyPy in production"
categories = ["Types", "Programming Languages", "Lessons", "Python", "Scala"]
comments = true
+++

# Lessons Learned using MyPy in Production

When we talk about type safety in the context of statically typed languages, we mean that the language builds in a typing checking mechanism into the compiler. No type-check, no compilation.

But in the context of research / algorithms oriented software that has no uptime requirements, the bias coming out of academia is to get the math into code, these days Python, and put it in production. Python is dynamically typed and has no type inference... so the typing is optional. What Mypy users rarely discuss is the cognitive burden of maintaining the type system that is separate from the code. With a lot of tasks on your plate and new features you are waiting to start, sometimes it feels silly to type annotate Python. Is this really necessary? 
```python
def(a):
    print(a)
    return

# With types
def(a: int) -> None:
    print(a)
    return
```
The situation we experience more often is that the simple and obvious functions get type annotated, but the complex ones that deal with uncommon types, like declaring types for decorators `F = TypeVar('F', bound=Callable[..., Any])`, go un-typed. And we expect this! Catching subtle bugs via the mypy type-checking mechanism is a long game.

Highly effective teams know that type annotation is one of the best ways to make a codebase _stronger_. I know that's a vague and probably incorrect word to use in the context of software, but it really feels that way in a Python codebase. Without type annotations, it's the blind leading the blind - you need faith that variable names accurately describe the data that code will operate on. "Faith" is cold-comfort when we start talking SLA's.

```python
def concatenate_str(x: str, y: str) -> str:
    return x + y

# the function name said '_str' but our data is 'int'
concatenate(1, 2) -> 3
```
 prevent programmer's from making dumb mistakes in their work. I believe that well-designed code is a force multiplier


  The following code will type check, even though the types are wrong. Mypy is a tool for type __annotation__; it's a document of what you want the types to be, and if the types are what you say they are, then the code is type safe.

# Lessons

So if the investment in type annotations (Mypy) only pays off with a full commitment, the most common scientific libraries are still working on type stubs, and no one has the time or willingness to fully commit, the question is, why even bother?

##  1. Mindfulness is enough to prevent common mistakes

Even if they go completely unused in any formal way, just making developers write types prevents dumb mistakes. For Python, this is often `Optional[T]` vs `[T]`. __This is not a joke__. Errors like this have led to downtime and rollbacks for production services. 
>"operator '>' not defined for Int and None" 

```python
# We have a vague understanding that 'a' is an int
__init__(self, val=None):
    func(val)

# No types - explosion
def func(a):
    if a > 3:
        return a
    else:
        return -1
    
# Types annotations remind us that 'a' can be None.
# either handle the Optional case (None), or prevent
# ever invoking 'func'
def func(a: Optional[int]) -> int:
    if a is None or a < 3:
        return -1
    else:
        return a
```

## 2. Don't use Python for production services

If your service has SLA's or has multiple downstream services, don't use Python. To have any chance at service stability, you'll need to fully use MyPy, and have some CI hooks that check for type soundness and prevent non type-annotated code from deploying. Your engineers will need to have the MyPy docs open frequently to maintain the type system, and from experience, you'll get a lot of complaints.

> "I know this code works - our test-suite passes, why am I wasting time getting MyPy to stop complaining about an unbound type?"

If you have to maintain a type system anyways, it's easier to choose a statically typed language where the compiler builds in type-checking. Also, most popular IDE's for statically typed languages have type hints - so by choosing Python you're just increasing the cognitive load for developers.

## 3. Configure MyPy to prevent returning Any

Developers are people, and people can be lazy. The laziest way to get around MyPy errors is to return type `Any` - the supertype of all types. This is like returning `Any` in Scala; as a last resort developers will do this to satisfy the type-checker so they can keep moving. Stop them, or at least make them annotate in code every time they really mean to return `Any`. Keep the MyPy file as concise as possible, but fail on any errors reported. 

```markdown
# file: mypy.ini

# global options:

[mypy]
warn_return_any = True
```

# Takeways

There's truth to the criticisms of trying to use Python in production. I've personally found that types lead to better code, and try to avoid dynamically typed code without type annotations at all costs - the extra time it takes to reconcile types always leads to stronger production code. It isn't static vs. dynamic, but instead interpreted vs. compiled that is the main differentiator in developer productivity.

# References

[1] Types for anyone who knows a programming language: https://www.destroyallsoftware.com/compendium/types?share_key=baf6b67369843fa2