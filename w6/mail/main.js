const Router = require('./router.js');
const Inbox = require('./inbox.js');


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
