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

            axios.patch(`/profile/avatar_update`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                    'Turbolinks-Referrer': false
                },
                timeout: 30000
            })
            .then((response) => {
                // 以下が実行されておらず、要対策が必要。
                // 画像は更新されているが、非同期のためか一度手動で更新すると変更後の画像が表示される
                console.log(response)
                if (response.data.success) {
                    const newAvatarUrl = response.data.avatar_url; // サーバー側で新しいアバターURLを返却する
                    $('#avatar_image').attr('src', newAvatarUrl + '?' + new Date().getTime()); // キャッシュ防止のためにタイムスタンプを付加
                    window.alert('アバターが更新されました');
                    
                }
                // window.location.reload()
                 
                // console.log('Avatar updated successfully:', response.data)
                // const newAvatarUrl = response.data.avatar_url
                // $('#avatar_image').attr('src', newAvatarUrl + '?' + new Date().getTime())

            })
            .catch(error => {
                if (error.code === 'ECONNABORTED') {
                    window.alert('リクエストがタイムアウトしました。ネットワーク接続を確認してください。')
                } else {
                    console.error('エラーが発生しました:', error.response ? error.response : error.message)
                }
            })
        }
    })
})