import "@hotwired/turbo-rails"
import Rails from "@rails/ujs"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false

import "./vendor/js/initialize"
import "select2"
import "./vendor/js/plugin"
import "chartkick"
import "Chart.bundle"
import autocomplete from "jquery-ui-dist";
// import * as trumbowyg_icon from 'https://raw.githubusercontent.com/Alex-D/Trumbowyg/main/dist/ui/icons.svg'
import "./vendor/js/custom"
import "vanilla-nested";
import "trumbowyg/trumbowyg";

import format_number_field from "./vendor/js/custom/format_number"
window.format_number_field = format_number_field

import change_recurring from "./vendor/js/custom/recurring"
window.change_recurring = change_recurring

import debt_form from "./vendor/js/custom/debt_form"
window.debt_form = debt_form

import credit_form from "./vendor/js/custom/credit_form"
window.credit_form = credit_form

import debt_item_form from "./vendor/js/custom/debt_item_form"
window.debt_item_form = debt_item_form

import credit_item_form from "./vendor/js/custom/credit_item_form"
window.credit_item_form = credit_item_form

import cash_book_category_click from "./vendor/js/custom/cash_book_category"
window.cash_book_category_click = cash_book_category_click
cash_book_category_click()

Rails.start()
