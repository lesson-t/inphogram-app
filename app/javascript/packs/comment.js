import $ from 'jquery'
import axios from 'modules/axios'

const handleCommentForm = () => {
    $('.show-comment-form').on('click', () => {
        $('.show-comment-form').addClass('hidden')
        $('.comment-text-area').removeClass('hidden')
    })
}

// const appendNewComment = (comment) => {
//     $('.comments-container').append(
//         `<div class="post_comment"><img src=${escape(comment.user.avatar_image)} /></div>`
//         `<div class="post_comment"><p>${escape(comment.user.name)}</p></div>`
//         `<div class="post_comment"><p>${escape(comment.content)}</p></div>`
//     ) 
// }

document.addEventListener('turbolinks:load', () => {

    const dataset = $('#comment-index').data()
    const postId = dataset.postId

    // axios.get(`/posts/${postId}/comments/new`)
    // .then((response) => {
    //     const comments = response.data
    //     comments.forEach((comment) => {
    //         appendNewComment(comment)
    //     });
    // })

    handleCommentForm()

    $('.add-comment-btn').on('click', () => {
        const content = $('#comment_content').val()
        if (!content) {
            window.alert('コメントを入力してください')
        } else {
            axios.post(`/posts/${postId}/comments`, {
                comment: {content: content}
            })
                .then((res) => {
                    $('#comment_content').val('')
                    window.location.reload()
                })
        }
    })

})