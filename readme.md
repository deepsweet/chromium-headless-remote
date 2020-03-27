[![version](https://img.shields.io/badge/chromium-80-green.svg?style=flat-square)](https://packages.ubuntu.com/bionic/chromium-browser) [![hub](https://flat.badgen.net/docker/pulls/deepsweet/chromium-headless-remote?label=pulls)](https://hub.docker.com/r/deepsweet/chromium-headless-remote/) [![size](https://flat.badgen.net/docker/size/deepsweet/chromium-headless-remote?label=size)](https://hub.docker.com/r/deepsweet/chromium-headless-remote/)

Dockerized Chromium in [headless](https://chromium.googlesource.com/chromium/src/+/lkgr/headless/README.md) [remote debugging mode](https://chromedevtools.github.io/devtools-protocol/).

## Usage

```sh
docker run -it --rm -p 9222:9222 deepsweet/chromium-headless-remote:80
```

Example using [Puppeteer](https://github.com/GoogleChrome/puppeteer):

Ensure to match version of `puppeteer-core` to the version of Chromium you are using:

```sh
npm install puppeteer-core@chrome-80
```

```js
import fetch from 'node-fetch'
import puppeteer from 'puppeteer-core'

const response = await fetch('http://localhost:9222/json/version')
const { webSocketDebuggerUrl } = await response.json()

const browser = await puppeteer.connect({ browserWSEndpoint: webSocketDebuggerUrl })
const page = await browser.newPage()

await page.goto('https://example.com')
await page.screenshot({ path: 'example.png' })
await browser.close()
```

## Fonts

It's possible to mount a folder with custom fonts to be used later by Chromium: add `-v $(pwd)/path/to/fonts:/home/chromium/.fonts` to `docker run` arguments.

## How to update to the newer Chromium version

Docker Hub's Auto Builder is used to create versioned builds. Build instructions are set to look at Git tag value and create a corresponding Dcoker image tag.

To update the version:
1. run `make list`
2. pick newer version and paste it (properly shortened) in [`Makefile`](./Makefile) and [`Dockerfile`](./Dockerfile)
3. commit all changes
4. run `make push`

## Related

* [ungoogled-chromium-headless-remote](https://github.com/deepsweet/ungoogled-chromium-headless-remote)
* [firefox-headless-remote](https://github.com/deepsweet/firefox-headless-remote)
