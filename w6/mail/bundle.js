/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const Router = __webpack_require__(1);
	const Inbox = __webpack_require__(2);


	let routes = {
	  // compose: Compose,
	  inbox: Inbox,
	  // sent: Sent
	};

	document.addEventListener("DOMContentLoaded", () => {
	  let content = document.querySelector(".content");
	  let router = new Router(content, routes);
	  router.start();
	  let navItems = Array.from(document.querySelectorAll(".sidebar-nav li"));
	  navItems.forEach(navItem => {
	    navItem.addEventListener("click", () => {
	      let name = navItem.innerText.toLowerCase();
	      window.location.hash = name;
	    });
	  });




	  // let content = document.querySelector(".content");
	  // router = new Router(content, routes);
	  // router.start();
	  // window.location.hash = "#inbox";
	  // let navItems = Array.from(document.querySelectorAll(".sidebar-nav li"));
	  // navItems.forEach(navItem => {
	  //   navItem.addEventListener("click", () => {
	  //     let name = navItem.innerText.toLowerCase();
	  //     location.hash = name;
	  //   });
	  // });
	});


/***/ },
/* 1 */
/***/ function(module, exports) {

	class Router {
	  constructor(node, routes) {
	    this.node = node;
	    this.routes = routes;
	  }

	  start() {
	    this.render();
	    window.addEventListener("hashchange", () => {
	      this.render();
	    });
	  }

	  render() {
	    this.node.innerHTML = "";
	    let component = this.activeRoute();
	    if (component) {
	      // component.render();
	      console.log(component);
	      console.log(component.render());
	      this.node.appendChild(component.render());
	    }

	    // let p = document.createElement("p");
	    // p.innerHTML = component;
	    // this.node.appendChild(p);
	  }

	  activeRoute() {
	    let hash = window.location.hash.slice(1);
	    let component = this.routes[hash];
	    return component;
	  }

	}

	module.exports = Router;


/***/ },
/* 2 */
/***/ function(module, exports) {

	




	module.exports = {
	  render() {
	    let mesEl = document.createElement("ul");
	    mesEl.className = "messages";
	    mesEl.innerHTML = "An inbox message.";
	    return mesEl;
	  }
	};


/***/ }
/******/ ]);