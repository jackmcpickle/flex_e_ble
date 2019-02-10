# flex_e_ble

[![NPM](https://nodei.co/npm/flex_e_ble.png)](https://npmjs.org/package/flex_e_ble)

[![Build Status](https://travis-ci.org/jackmcpickle/flex_e_ble.svg?branch=master)](https://travis-ci.org/jackmcpickle/flex_e_ble) [![Dev Dependencies](https://david-dm.org/jackmcpickle/flex_e_ble/dev-status.svg)](https://david-dm.org/jackmcpickle/flex_e_ble?type=dev&view=list) ![Total Downloads](https://img.shields.io/npm/dt/flex_e_ble.svg) [![renovate-app badge][renovate-badge]][renovate-app]

[renovate-badge]: https://img.shields.io/badge/renovate-app-blue.svg
[renovate-app]: https://renovateapp.com/

A simple yet *flexible* class naming structure on top of a `flex` based grid.

Reasons
* Provides a `inline-block` fall back for IE8 & 9
* Can assist you in migrating your current Bootstrap and Foundation grids to flexbox as a drop in replacement.
* Use a grid system that is the same across your projects but adapts to the naming conventions that your are used to.

See the website [flexeble.space](https://flexeble.space/) for demo examples

See all [customisable variables](https://github.com/jackmcpickle/flex_e_ble/blob/master/src/scss/modules/_vars.scss)

## Requirements

* [modernizr](https://modernizr.com/download?flexbox-setclasses-shiv) to provide flexbox detection
* [include-media](https://github.com/eduardoboucas/include-media) for responsive grid generation

## Install

* `npm install flex_e_ble` or copy `dist/_flex_e_ble.scss`

## How it works

Flex_e_ble grid system is based on [purecss.io](http://purecss.io/) grid work.

[Read why](http://purecss.io/grids/#using-grids-with-custom-fonts) they using negative letter-spacing to remove the white-space from the inline-block fallback display.

Row css looks like
```scss
.row {
  display: flex;
  flex-flow: row wrap;
  position: relative;
  letter-spacing: -0.31em;
  text-rendering: optimizespeed;
}

```

Grid css looks like
```scss
[class*=grid-] {
  display: inline-block;
  letter-spacing: normal;
  text-rendering: auto;
}
```

## Usage

A basic grid class structure is a follows ```.$global-name-space-$grid-name-$breakpointsize-$columnindex```


Make a simple 5 column grid with 30px gutters either side
```scss
@import 'flex_e_ble';
$total-columns: 5;
$column-gutter: 30px;
$auto-column-gutters: true;
```

Will output the grid as follows

```css

.grid-1 { width: 20%; }

.grid-2 { width: 40%; }

/*...etc... */

```


Want a Bootstrap class structure?
```scss
@import 'flex_e_ble'
// Bootstrap like
$grid-name: 'col-';
$base-grid-name: 'xs';
$column-gutter: 15px;
$auto-column-gutters: true;
$right-name: 'push';
$left-name: 'pull';
$breakpoints: (
  'sm': 480px,
  'md': 768px,
  'lg': 1024px,
  'xl': 1180px
);
```

Outputs a grid using the bootstrap naming convention
```css
.col-xs-1 { width: 8.33333%; }

.col-xs-2 { width: 16.66667%; }

/*...etc... */
```

Want a Foundation class structure?
```scss
@import 'flex_e_ble';
// foundation like;
$column-gutter: 0.9375rem;
$auto-column-gutters: false;
$independant-grid-name: 'column';
$grid-name: '';
$base-grid-name: 'small';
$breakpoints: (
  'medium': 768px,
  'large': 1024px
);
```

Will output our grid as follows
```css
.small-1 { width: 8.33333%; }

.small-2 { width: 16.66667%; }

/*...etc... */
```

But remember underneath the properties outputted are just the same.
