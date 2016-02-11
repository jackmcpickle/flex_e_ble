# flex_e_ble

A simple yet *flexible* class naming structure on top of a flex box based grid.

Also provides a inline-block fall back for < IE9

Use a grid system is the the same across your projects but adapts to the naming conventions that your are used to.

## Requirements

* [modernizr](https://modernizr.com/download?flexbox-setclasses-shiv) for flexbox fallback
* [include-media](https://github.com/eduardoboucas/include-media) for responsive grid generation

## Install

* `npm install flex_e_ble include-media`
* `bower install flex_e_ble include-media`

## How it works

Flex_e_ble grid system is based on [purecss.io](http://purecss.io/)

[Read why](http://purecss.io/grids/#using-grids-with-custom-fonts) they using negative letter-spacing to remove the white-space from the inline-block fallback display

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


Make a simple 5 column grid with 30px padding either side
```sass
@import "flex_e_ble"
$total-columns: 5
$column-gutter: 30px
$auto-column-gutters: true;
```

Outputs a grid using the bootstrap naming convention

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

Will output our grid as follows
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
