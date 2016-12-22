/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const FollowToggle = __webpack_require__(1);
	const UsersSearch = __webpack_require__(3);
	const TweetCompose = __webpack_require__(4);
	
	$(() => {
	  $('.follow-toggle').each(function(idx, el) {
	    new FollowToggle(el);
	  });
	  $('.users-search').each(function(idx, el) {
	    new UsersSearch(el);
	  });
	
	  $('.tweet-compose').each(function(idx, el) {
	    new TweetCompose(el);
	  });
	
	});


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	
	class FollowToggle {
	  constructor($el) {
	    this.$el = $($el);
	    this.userId = this.$el.data("user-id");
	    this.followState = this.$el.data("initial-follow-state");
	    this.render();
	    this.$el.on("click", function(e) {
	      return this.handleClick(e);
	    }.bind(this)
	  );
	  }
	
	  render() {
	    if (this.followState === "following" || this.followState === "unfollowing") {
	      this.$el.prop("disabled", true);
	    } else {
	      const follow = this.followState === "unfollowed" ? "Follow!" : "Unfollow!";
	      this.$el.text(follow);
	      this.$el.prop("disabled", false);
	
	    }
	  }
	
	  toggleState() {
	    this.followState = this.followState === "following" ? "followed" : "unfollowed";
	  }
	
	  handleClick(e) {
	    e.preventDefault();
	    const that = this;
	    if ( this.followState === "unfollowed") {
	      this.followState = "following";
	      this.render();
	      APIUtil.followUser(this.userId).then(() => {
	        this.toggleState();
	        this.render();
	      });
	    } else {
	      this.followState = "unfollowing";
	      this.render();
	      APIUtil.unfollowUser(this.userId).then(() => {
	        this.toggleState();
	        this.render();
	      });
	
	    }
	  }
	}
	
	
	module.exports = FollowToggle;


/***/ },
/* 2 */
/***/ function(module, exports) {

	const APIUtil = {
	  followUser: id => {
	    return $.ajax ({
	              method: "POST",
	              url: `/users/${id}/follow`,
	              dataType: "json"
	            });
	  },
	
	  unfollowUser: id => {
	    return $.ajax ({
	              method: "DELETE",
	              url: `/users/${id}/follow`,
	              dataType: "json"
	            });
	  },
	
	  searchUsers: (queryVal, success) => {
	    return $.ajax ({
	              method: "GET",
	              url: "/users/search",
	              dataType: "json",
	              data: {"query": queryVal},
	              success
	            });
	  },
	
	  createTweet: formData => {
	    return $.ajax ({
	      method: "POST",
	      url: "/tweets",
	      dataType: "json",
	      data: formData
	    });
	  }
	};
	
	module.exports = APIUtil;


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	const FollowToggle = __webpack_require__(1);
	class UsersSearch {
	  constructor ($el) {
	    this.$el = $($el);
	    this.input = this.$el.find("input");
	    this.ul = this.$el.find("ul");
	    console.log(this.$el);
	    this.$el.on("input", function(e) {
	      return this.handleInput(e);
	    }.bind(this)
	  );
	}
	
	  handleInput(e) {
	    e.preventDefault();
	    APIUtil.searchUsers(this.input.val(), this.renderResults.bind(this));
	  }
	
	  renderResults(arg) {
	    this.ul.empty();
	    arg.forEach((el) => {
	      const $li = $("<li></li>");
	      const $a = $("<a></a>");
	      $a.attr("href", `/users/${el.id}`);
	      $a.text(el.username);
	      $li.append($a);
	      const button = $(`<button type="button" class="follow-toggle"
	              data-user-id="${el.id}"
	              data-initial-follow-state="${el.follow_state}"></button>`);
	      new FollowToggle(button);
	      $li.append(button);
	      this.ul.append($li);
	    });
	  }
	}
	
	
	module.exports = UsersSearch;


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	
	class TweetCompose {
	  constructor(el) {
	    this.$el = $(el);
	    this.targetUl = this.$el.data("tweets-ul");
	    this.inputArea = this.$el.find("textarea");
	    this.inputArea.on("input", this.updateRemainChars.bind(this));
	    this.$el.on("submit", (e) => this.submit(e));
	
	    this.$el.find(".add-mentioned-user")
	             .on("click", this.addMentionedUser.bind(this));
	    this.$el.on("click", "a.remove-mentioned-user" , e => this.removeMentionedUser(e));
	
	  }
	
	  submit(e) {
	    e.preventDefault();
	    const formJson = this.$el.serializeJSON();
	    this.$el.filter(":input").attr("disabled", "true");
	    APIUtil.createTweet(formJson).then(this.handleSuccess.bind(this));
	  }
	
	  clearInput() {
	    this.$el.find("textarea").val("");
	    this.$el.find("select").val("");
	  }
	
	  handleSuccess(arg) {
	    this.clearInput();
	    const $li = $("<li></li>");
	    const $a = $("<a></a>");
	    $a.text(arg.user.username);
	    $a.attr("href", `/users/${arg.user.id}`);
	    $li.append(`${arg.content} -- `);
	    $li.append($a);
	    $li.append(` -- ${arg.created_at}`);
	    $(this.targetUl).prepend($li);
	  }
	
	  updateRemainChars() {
	    const l = this.inputArea.val().length;
	    this.$el.find(".chars-left").text(`${140 - l}`);
	  }
	
	  addMentionedUser() {
	    const scriptHTML = this.$el.find("script").html();
	    this.$el.find(".mentioned-users").append(scriptHTML);
	    return false;
	  }
	
	  removeMentionedUser(e) {
	    e.preventDefault();
	    $(e.currentTarget).parent().remove();
	  }
	
	}
	
	module.exports = TweetCompose;


/***/ }
/******/ ]);
//# sourceMappingURL=bundle.js.map