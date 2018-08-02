[![chromium version](https://img.shields.io/badge/chromium-68-green.svg?style=flat-square)](https://pkgs.alpinelinux.org/package/edge/community/x86_64/chromium) [![alpine version](https://img.shields.io/badge/alpine-3.7-green.svg?style=flat-square)](https://www.alpinelinux.org/) [![build](https://img.shields.io/docker/build/deepsweet/chromium-headless-remote.svg?label=build&style=flat-square)](https://hub.docker.com/r/deepsweet/chromium-headless-remote/) [![size](https://img.shields.io/microbadger/image-size/deepsweet/chromium-headless-remote.svg?label=size&style=flat-square)](https://microbadger.com/images/deepsweet/chromium-headless-remote)

```sh
docker run -it --rm -p 9222:9222 deepsweet/chromium-headless-remote:68
```

```js
import puppeteer from 'puppeteer'
import request from 'request-promise-native'

(async () => {
  const { body: { webSocketDebuggerUrl } } = await request({
    uri: 'http://localhost:9222/json/version',
    json: true,
    resolveWithFullResponse: true
  })
  const browser = await puppeteer.connect({
    browserWSEndpoint: webSocketDebuggerUrl
  })
  const page = await browser.newPage()

  await page.goto('https://example.com')
  await page.screenshot({ path: 'example.png' })
  await browser.close()
})()
```
