# DSK International Website

Static Website for DSK International.

## Template

The basic site was generated with [Middleman Boilerplate]:
The template uses [Webpack] for asset processing through the external pipeline. Features include:

- [Sass]
- [Autoprefixer]
- [Babel]

  [Webpack]: https://webpack.js.org/
  [Sass]: https://sass-lang.com
  [Autoprefixer]: https://github.com/postcss/autoprefixer
  [Babel]: https://babeljs.io
  [Middleman Boilerplate]: https://github.com/Rjoss/middleman-webpack-bootstrap

## Install

```sh
bundle config set path 'vendor/bundle'
bundle
npm i
```

## Develop

Run development server with:

```sh
bundle exec middleman server
```

Open URL http://localhost:4567/ as preview.

## Build & Deploy

<TBD>
