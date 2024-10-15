import $ from 'jquery'
import axios from 'modules/axios'

const handleFollowDisplay = (hasFollowed) => {
    if (hasFollowed) {
        $('.active-follow').removeClass('hidden')
        $('.active-unfollow').addClass('hidden')
    } else {
        $('.active-unfollow').removeClass('hidden')
        $('.active-follow').addClass('hidden')
    }
}



document.addEventListener('turbolinks:load', () => {

    const dataset = $('#account-show').data()
    if (dataset && dataset.accountId && dataset.followedId) {
        const accountId = dataset.accountId
        const followedId = dataset.followedId

        axios.get(`/accounts/${accountId}/follows/${followedId}`)
            .then((response) => {
                const hasFollowed = response.data.hasFollowed
                handleFollowDisplay(hasFollowed)
        })

        // Followする時、Follow を押して Unfollow を表示
        $('.active-unfollow').on('click', () => {
            axios.post(`/accounts/${accountId}/follows`)
            .then((response) => {
                if (response.data.status == 'ok' ) {
                    $('.active-follow').removeClass('hidden')
                    $('.active-unfollow').addClass('hidden')
                }
            })
            .catch((e) => {
                window.alert('Error')
                console.log(e)
            })
        })

        // Unfollowする時、Unfollow を押して Follow を表示
        $('.active-follow').on('click', () => {
            axios.post(`/accounts/${accountId}/unfollows`)
            .then((response) => {
                if (response.data.status == 'ok' ) {
                    $('.active-unfollow').removeClass('hidden')
                    $('.active-follow').addClass('hidden')
                }
            })
            .catch((e) => {
                window.alert('Error')
                console.log(e)
            })
        })
    }
})