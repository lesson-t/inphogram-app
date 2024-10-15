import $ from 'jquery'
import axios from 'modules/axios'

document.addEventListener('turbolinks:load', () => {

    const dataset = $('#comment-index').data()
    if (dataset) {
        const postId = dataset.postId

        const postComment = () => {
            const content = $('#comment_content').val()
            if (!content) {
                window.alert('コメントを入力してください')
            } else {
                axios.post(`/api/posts/${postId}/comments`, {
                    comment: {content: content}
                })
                    .then((res) => {
                        $('#comment_content').val('')
                        window.location.reload()
                    })
            }
        }

        // 画像をクリックしたときのイベント
        $('.comment-icon').one('click', postComment)
    }
})