import jQuery from "jquery"
import toastr from "toastr/toastr"
import moment from "moment"
import Tagify from '@yaireo/tagify'

window.$ = window.jQuery = jQuery
window.toastr = toastr
window.moment = moment

document.addEventListener('DOMContentLoaded', () => {
  window.Tagify = Tagify;
})
