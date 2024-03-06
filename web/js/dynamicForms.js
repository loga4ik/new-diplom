const App = {
  data() {
    return {
      viewName: ["загрузить файл", "ввести данные вручную"],
      isFileInput: false,
    };
  },
  methods: {
    isFileInputClickHandler() {
      this.isFileInput = !this.isFileInput;
      //   if (this.viewName == "загрузить файл") {
      //     this.viewName = "ввести данные вручную";
      //   } else {
      //     this.viewName = "загрузить файл";
      //   }
    },
  },
};
Vue.createApp(App).mount("#createTeacher");
