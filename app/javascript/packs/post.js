import $ from 'jquery'
import axios from 'modules/axios'

const handleHeartDisplay = (hasLiked) => {
    if (hasLiked) {
        $('.active-heart').removeClass('hidden')
        $('.inactive-heart').addClass('hidden')
    } else {
        $('.inactive-heart').removeClass('hidden')
        $('.active-heart').addClass('hidden')
    }
}

document.addEventListener('turbolinks:load', () => {

    const dataset = $('#post-show').data()
    const postId = dataset.postId

    axios.get(`/api/posts/${postId}/like`).then((response) => {
        const hasLiked = response.data.hasLiked
        handleHeartDisplay(hasLiked)
    })

    $('.inactive-heart').on('click', () => {
        axios.post(`/api/posts/${postId}/like`)
        .then((response) => {
            if (response.data.status == 'ok' ) {
                $('.active-heart').removeClass('hidden')
                $('.inactive-heart').addClass('hidden')
            }
        })
        .catch((e) => {
            window.alert('Error')
            console.log(e)
        })
    })

    $('.active-heart').on('click', () => {
        axios.delete(`/api/posts/${postId}/like`)
        .then((response) => {
            if (response.data.status == 'ok' ) {
                $('.inactive-heart').removeClass('hidden')
                $('.active-heart').addClass('hidden')
            }
        })
        .catch((e) => {
            window.alert('Error')
            console.log(e)
        })
    })
})