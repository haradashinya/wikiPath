var links = [];

// set selected from last data.


window.setIndex = function(item){
  console.log("item is " + item);
  var idx = 0;
  if (item === "Rome"){
    idx = 0;
  }else if (item === "Women"){
    idx = 1;
  }else if (item === "Soccer"){
    idx = 2;
  }else if (item === "Apple"){
    idx = 3;
  }
  var d = document.querySelectorAll(".li");
  d[idx].style.background = "#95a5a6";
  console.log(item);
  links.push(d[idx]);

};


tappable('a',function(item){
  if(links.length > 0){
    for(var i = 0 ; i < links.length;i++){
      var link = links[i];
      link.style.background = "white";
    }
  }
  item.target.style.background = "#95a5a6";
  links.push(item.target);
  window.location.href = "api://save/" + item.target;
});
