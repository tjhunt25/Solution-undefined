
$(document).ready(function() {
  $('.showSolutionButton').click(function(event){
    $(".hiddenSolutions").toggleClass("show");
    if ($(".showSolutionButton").html() === "Click Here To Show Solutions")
      $(".showSolutionButton").html("Quick Teacher's Coming. Hide!");
    else
      $(".showSolutionButton").html("Click Here To Show Solutions");
  });
})
