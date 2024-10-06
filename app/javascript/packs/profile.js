import $ from 'jquery'
import axios from 'modules/axios'

const handleAvatarUpload = () => {
    // アバター画像をクリックしてファイル選択ダイアログを表示
    $('#avatar_image').on('click', () => {
        $('#fileInput').click(); // ファイル選択ダイアログを表示
    });

    // ファイルが選択された場合
    $('#fileInput').on('change', (event) => {
        const fileInput = event.target;
        const avatar = fileInput.files[0];

        if (!avatar) {
            window.alert('画像を選択してください');
        } else {
            const formData = new FormData();
            formData.append('profile[avatar]', avatar);

            axios.patch(`/profile/avatar_update`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                    'Turbolinks-Referrer': false
                },
                timeout: 30000
            })
            .then((response) => {
                if (response.data.success) {
                    const newAvatarUrl = response.data.avatar_url; // サーバーから返却された新しいアバターURL
                    $('#avatar_image').attr('src', newAvatarUrl + '?' + new Date().getTime()); // キャッシュ防止のためにタイムスタンプを付加
                    window.alert('アバターが更新されました');
                }
            })
            .catch(error => {
                if (error.code === 'ECONNABORTED') {
                    window.alert('リクエストがタイムアウトしました。ネットワーク接続を確認してください。');
                } else {
                    console.error('エラーが発生しました:', error.response ? error.response : error.message);
                }
            });
        }
    });
}

document.addEventListener('turbolinks:load', () => {
    handleAvatarUpload();
});