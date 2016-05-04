# flex_e_ble

[![NPM](https://nodei.co/npm/flex_e_ble.png)](https://npmjs.org/package/flex_e_ble)

A simple yet *flexible* class naming structure on top of a `flex` based grid. 

Reasons
* Provides a `inline-block` fall back for IE8 & 9
* Can assist you in migrating your current Bootstrap and Foundation grids to flexbox as a drop in replacement.
* Use a grid system that is the same across your projects but adapts to the naming conventions that your are used to.

See the website [flexeble.space](https://flexeble.space/) for demo examples

## Requirements

* [modernizr](https://modernizr.com/download?flexbox-setclasses-shiv) to provide flexbox detection
* [include-media](https://github.com/eduardoboucas/include-media) for responsive grid generation

## Install

* `npm install flex_e_ble`
* `bower install flex_e_ble`

## How it works

Flex_e_ble grid system is based on [purecss.io](http://purecss.io/) grid work.

[Read why](http://purecss.io/grids/#using-grids-with-custom-fonts) they using negative letter-spacing to remove the white-space from the inline-block fallback display.

Row css looks like
```sass
.row
  letter-spacing: -0.31em
  text-rendering: optimizespeed
  box-sizing: border-box
  position: relative
  display: flex
  flex-flow: row wrap
```

Grid css looks like
```sass
[class*=grid-]
  display: inline-block
  letter-spacing: normal
  text-rendering: auto
  word-spacing: normal
  vertical-align: top
  box-sizing: border-box
```

## Usage

A basic grid class structure is a follows ```.$global-name-space-$grid-name-$breakpointsize-$columnindex```


Make a simple 5 column grid with 30px gutters either side
```sass
@import "flex_e_ble"
$total-columns: 5
$column-gutter: 30px
$auto-column-gutters: true
```

Will output the grid as follows

```css

.grid-1 { width: 20%; }

.grid-2 { width: 40%; }

/*...etc... */

```


Want a Bootstrap class structure?
```sass
@import "flex_e_ble"
$grid-framework: 'bootstrap'
```

Outputs a grid using the bootstrap naming convention
```css
.col-xs-1 { width: 8.33333%; }

.col-xs-2 { width: 16.66667%; }

/*...etc... */
```

Want a Foundation class structure?
```sass
@import "flex_e_ble"
$grid-framework: 'foundation'
```

Will output our grid as follows
```css
.small-1 { width: 8.33333%; }

.small-2 { width: 16.66667%; }

/*...etc... */
```

But remember underneath the properties outputted are just the same.
