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

## Usage

A basic grid class structure is a follows ```.$global-name-space-$grid-name-$breakpointsize-$columnindex```

```sass
@import "flex_e_ble"
$grid-name: 'col-'
$grid-base-name: 'xs'
$column-gutter: 15px
$auto-column-gutters: true
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
$column-gutter: 0.9375rem
$auto-column-gutters: false
$grid-padding-name: 'column'
$grid-name: ''
$default-grid-name: 'small'
// needed as our grid-name is blank
$independant-grid-definition: true
```

Will output our grid as follows
```css
.small-1 { width: 8.33333%; }

.small-2 { width: 16.66667%; }

/*...etc... */
```

But remember underneath the properties outputted are just the same.
