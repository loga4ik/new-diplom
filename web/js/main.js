document.addEventListener("DOMContentLoaded", function () {
  new Vue({
    el: "#app",
    data: {
      isCreate: true,
      form: {
        title: "",
        subject_id: "",
        questions: [],
      },
      subjects: [], // Преобразованные данные предметов
      levels: [], // Преобразованные данные уровней
      types: [], // Преобразованные данные типов
    },
    methods: {
      addQuestion() {
        this.form.questions.push({
          imageFile: "",
          text: "",
          level_id: "",
          type_id: "",
        });
      },
      removeQuestion(index) {
        this.form.questions.splice(index, 1);
      },
      async submitForm() {
        try {
          const response = await fetch("/api/form/submit", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify(this.form),
          });

          const result = await response.json();

          if (result.success) {
            alert("Form submitted successfully");
          } else {
            alert("Form submission failed");
          }
        } catch (error) {
          console.error("Error submitting form:", error);
        }
      },
      async fetchData(url) {
        const response = await fetch(url);
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return await response.json();
      },
      transformData(data) {
        // Преобразуем объект в массив объектов с полями id и name
        return Object.keys(data).map((key) => ({
          id: key,
          name: data[key],
        }));
      },
    },
    async mounted() {
      try {
        const subjectsData = await this.fetchData(
          "/teacher/test/get-all-subjects"
        );
        const levelsData = await this.fetchData("/teacher/test/get-all-levels");
        const typesData = await this.fetchData("/teacher/test/get-all-types");

        // Преобразуем данные предметов, уровней и типов
        this.subjects = this.transformData(subjectsData);
        this.levels = this.transformData(levelsData);
        this.types = this.transformData(typesData);
        
        this.subjects.map((subject) => {
          console.log("Subjects:", subject.name);
        });
        this.levels = this.transformData(levelsData);
        this.types = this.transformData(typesData);

        // console.log("Subjects:", this.subjects);
        console.log("Levels:", this.levels);
        console.log("Types:", this.types);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    },
  });
});
