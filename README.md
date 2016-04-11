# AngularJS directive for Bricks.js

## Install

Install with bower
```
bower install angular-bricks.js
```

*or*
Install with NPM
```
npm install angular-bricks.js
```

Mark this module as a dependency in your angular app

```
angular.module('myApp', ['angular-bricksjs']);
```

## Usage 

```
<div imago-bricksjs source="items" sizes="sizes" packed="packed">
	<div ng-repeat="item in items"></div>
</>
```

More information in [Bricks.js](https://github.com/callmecavs/bricks.js)