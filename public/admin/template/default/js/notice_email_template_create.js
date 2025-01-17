(function (window, undefined) {
  var old_onload = window.onload
  window.onload = function () {
    const template = document.getElementsByClassName('notice-email-template-create')[0]
    Vue.prototype.lang = window.lang
    new Vue({
      data () {
        return {
          formData: {
            name:'',
            subject: '',
            message: ''
          },
          rules: {
            name: [
              { required: true, message: lang.input + lang.nickname, type: 'error' },
              { validator: val => val.length <= 100, message: lang.verify3 + 100, type: 'warning'}
            ],
            subject: [
              { required: true, message: lang.input + lang.title, type: 'error' },
              { validator: val => val.length <= 100, message: lang.verify3 + 100, type: 'warning'}
            ],
            message: [{ required: true, message: lang.input + lang.content, type: 'error' }],
          },
        }
      },
      created () {

      },
      mounted () {
        this.initTemplate()
      },
      methods: {
        setContent () {
          this.formData.message = tinymce.editors['emailTemp'].getContent({ format: 'text' })
        },
        submit () {
          this.setContent()
          this.$refs.userDialog.validate().then(async res => {
            try {
              const res = await createEmailTemplate('create', this.formData)
              this.$message.success(res.data.msg)
              setTimeout(() => {
                location.href = 'notice_email_template.html'
              }, 500)
            } catch (error) {
              this.$message.error(error.data.msg)
            }
          }, error => {
            console.log(error)
          })
        },
        initTemplate () {
          tinymce.init({
            selector: '#emailTemp',
            language_url: '/tinymce/langs/zh_CN.js',
            language: 'zh_CN',
            min_height: 400,
            width: '100%'
          });
        },
        close () {
          location.href = 'notice_email_template.html'
         },
      },
    }).$mount(template)
    typeof old_onload == 'function' && old_onload()
  };
})(window);
