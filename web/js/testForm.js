const countLevelQ = () => {
  $(".select-level").on("click", function () {
    let countH = Array.from(
      document.querySelectorAll("select.select-level")
    ).filter((select) => select.value === "3");
    let countM = Array.from(
      document.querySelectorAll("select.select-level")
    ).filter((select) => select.value === "2");
    let countE = Array.from(
      document.querySelectorAll("select.select-level")
    ).filter((select) => select.value === "1");
    console.log(countH.length);
    $("#status-count-h").text(countH.length);
    $("#status-count-m").text(countM.length);
    $("#status-count-e").text(countE.length);
  });
};

const createData = (count = 0) => {
  let a = $(".container-items").children().length;
  $("#count-questions").text($(".container-items").children().length + count);
};

$(".add-question").on("click", function () {
  createData(1);
  setTimeout(() => {
    countLevelQ();
  }, 1000);
});
createData();
countLevelQ();
