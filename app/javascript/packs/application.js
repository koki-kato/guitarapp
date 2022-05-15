import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"


import '../javascripts/application.js'
import '../stylesheets/application.scss'

Rails.start()
Turbolinks.start()
ActiveStorage.start()