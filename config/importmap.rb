# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'

pin_all_from 'app/javascript/controllers', under: 'controllers'

pin 'jquery', to: 'https://ga.jspm.io/npm:jquery@3.6.1/dist/jquery.js'
pin "jquery-ui-dist", to: "https://ga.jspm.io/npm:jquery-ui-dist@1.13.1/jquery-ui.js"
pin '@popperjs/core', to: 'https://ga.jspm.io/npm:@popperjs/core@2.10.2/lib/index.js'
pin '@rails/ujs', to: 'https://ga.jspm.io/npm:@rails/ujs@7.0.4/lib/assets/compiled/rails-ujs.js'
pin 'bootstrap', to: 'https://ga.jspm.io/npm:bootstrap@5.1.3/dist/js/bootstrap.esm.js'
pin '@fontsource/raleway', to: 'https://ga.jspm.io/npm:@fontsource/raleway@4.5.11/index.css'
pin 'aos', to: 'https://ga.jspm.io/npm:aos@2.3.4/dist/aos.js'
pin 'typeface-montserrat', to: 'https://ga.jspm.io/npm:typeface-montserrat@1.1.13/index.css'
pin 'toastr/toastr', to: 'https://ga.jspm.io/npm:toastr@2.1.4/toastr.js'
pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"
pin 'select2', to: 'https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.full.js'
pin 'trumbowyg/trumbowyg', to: 'https://cdnjs.cloudflare.com/ajax/libs/Trumbowyg/2.26.0/trumbowyg.min.js'
pin 'progressbar.js', to: 'https://cdnjs.cloudflare.com/ajax/libs/progressbar.js/0.6.1/progressbar.min.js'
pin 'copy-to-clipboard', to: 'https://cdn.jsdelivr.net/npm/copy-to-clipboard@3.3.3/index.min.js'
pin "vanilla-nested", to: "vanilla_nested.js", preload: true
pin 'moment', to: 'https://ga.jspm.io/npm:moment@2.29.4/moment.js'
pin '@yaireo/tagify', to: 'https://ga.jspm.io/npm:@yaireo/tagify@4.16.4/dist/tagify.min.js'
