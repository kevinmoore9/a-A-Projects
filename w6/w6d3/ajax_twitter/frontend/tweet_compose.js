const APIUtil = require('./api_util.js');

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
