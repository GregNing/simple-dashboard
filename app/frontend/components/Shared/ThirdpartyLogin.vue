<template>
  <div>
    <button v-facebook-login-button="appId" class="facebook-login-button">
      LognIn
    </button>
  </div>
</template>
<script>
import { OmniauthLogin } from '@/graphql/Queries/User'
import FacebookLoginButton from '@/utils/FacebookLoginButton'
import { useMutation } from '@vue/apollo-composable'
import {assign, pick, get} from 'lodash'
import { createToast } from 'mosha-vue-toastify'

export default {
  directives: {
    facebookLoginButton: FacebookLoginButton
  },
  name: 'ThirdpartyLogin',
  data: () => ({
    appId: import.meta.env.VITE_FACEBOOK_APP_ID
  }),
  setup() {
    const { mutate: omniauthLoginMutation } = useMutation(OmniauthLogin, () => ({ fetchPolicy: 'no-cache'}))
    const OnFacebookAuthSuccess = async (authResponse, profileResponse) => {
      const user = assign(pick(profileResponse, ['email', 'name']),
      {
          accessToken: authResponse.accessToken,
          uid: get(profileResponse, 'id'),
          provider: authResponse.graphDomain
      })

      try {
        const result = await omniauthLoginMutation(user)
        const data = get(result, 'data.omniauthLogin')

        if(data.success) {
        } else {
        }
      } catch (error) {
      }
    }
    const OnFacebookAuthFail = (authErrorResponse) => {
      createToast(authErrorResponse, {type: 'danger'})
    }

    return {
      OnFacebookAuthSuccess,
      OnFacebookAuthFail
    }
  }
};
</script>
