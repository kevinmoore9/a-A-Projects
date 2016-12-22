const APIUtil = require('./api_util.js');
const FollowToggle = require('./follow_toggle.js');
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
