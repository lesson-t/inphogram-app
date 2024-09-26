import $ from 'jquery'
import axios from 'modules/axios'

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