const APIUtil = require('./api_util.js');

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
