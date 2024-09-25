// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

const handleAvatarForm = () => {
    $('.image_file_upload').on('click', () => {
        $('#fileInput').removeClass('hidden')
        $('#fileInputButton').removeClass('hidden')
    })
}

document.addEventListener('turbolinks:load', () => {

    handleAvatarForm()

    $('#fileInputButton').on('click', () => {
        const fileInput = $('#fileInput')[0]
        const avatar = fileInput.files[0]

        if (!avatar) {
            window.alert('画像を選択してください')
        } else {
            const formData = new FormData()
            formData.append('profile[avatar]', avatar)

            axios.patch(`/profile`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            })
            .then((response) => {
                // 以下が実行されておらず、要対策が必要。
                // 画像は更新されているが、非同期のためか一度手動で更新すると変更後の画像が表示される 
                console.log('Avatar updated successfully:', response.data)
                const newAvatarUrl = response.data.avatar_url
                $('#avatar_image').attr('src', newAvatarUrl + '?' + new Date().getTime())

            })
            .catch(error => {
    
                console.log('Error updating avatar:', error)
            })
        }
    })
})