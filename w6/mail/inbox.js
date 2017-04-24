




module.exports = {
  render() {
    let mesEl = document.createElement("ul");
    mesEl.className = "messages";
    mesEl.innerHTML = "An inbox message.";
    return mesEl;
  }
};
