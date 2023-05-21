+++
title = "Downloading all the CVPR Papers"
date = 2023-05-20
description = "Downloading All CVPR 2023 Papers"
categories = []
comments = false
+++

<hr>

This code will download all CVPR 2023 papers to your local machine. I haven't included any filters, but those are easy to add with this template in place.

```python
#!/usr/bin/env python

import os
import requests
from bs4 import BeautifulSoup
from pathlib import Path
from tqdm import tqdm

def main():

    root_path = "./Desktop/CVPR2023_Papers"
    base_url = "https://openaccess.thecvf.com"
    url=f"{base_url}/CVPR2023?day=all"

    os.makedirs(root_path, exist_ok=True)

    response = requests.get(url)

    # Create a BeautifulSoup object from the response
    soup = BeautifulSoup(response.content, "html.parser")

    # Outer <dl> element
    dl_element = soup.find_all("dl")[0]

    indiv_papers = dl_element.find_all("dt", class_="ptitle")

    for ix, paper in tqdm(enumerate(indiv_papers)):
        title = paper.find("a").text
        folder_name = title.replace(" ", "")

        paper_href = paper.find_next("a", string="pdf")["href"]
        supplement_href = paper.find_next("a", string="supp")["href"]

        folder_path = f"{root_path}/{folder_name}"
        os.makedirs(folder_path, exist_ok=True)

        with open(os.path.join(folder_path, Path(paper_href).name), "wb") as f:
            f.write(requests.get(f"{base_url}/{paper_href}").content)

        with open(os.path.join(folder_path, Path(supplement_href).name), "wb") as f:
            f.write(requests.get(f"{base_url}/{supplement_href}").content)            

if __name__ == "__main__":
    main()
```
