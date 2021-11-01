<template>
  <div>
    <button v-facebook-login-button="appId" class="facebook-login-button mx-2">
      FB LogIn
    </button>

    <button @click="handleGoogleClickLogin" class="google-login-button mx-2">
      Google LogIn
    </button>
  </div>
</template>
<script lang="ts">
import { OmniauthLogin } from "@/graphql/Queries/User";
import FacebookLoginButton from "@/utils/FacebookLoginButton";
import { useMutation } from "@vue/apollo-composable";
import { assign, pick, get } from "lodash";
import { createToast } from "mosha-vue-toastify";
import { getCurrentInstance } from "vue";
import { useRouter } from 'vue-router'

export default {
  directives: {
    facebookLoginButton: FacebookLoginButton,
  },
  name: "ThirdpartyLogin",
  data: () => ({
    appId: import.meta.env.VITE_FACEBOOK_APP_ID
  }),
  setup() {
    const router = useRouter()
    const app = getCurrentInstance();
    const googleAuth = app.appContext.config.globalProperties.$gAuth;

    const { mutate: omniauthLoginMutation } = useMutation(
      OmniauthLogin,
      () => ({ fetchPolicy: "no-cache" })
    );
    const OnFacebookAuthSuccess = async (authResponse, profileResponse) => {
      const user = assign(pick(profileResponse, ["email", "name"]), {
        accessToken: authResponse.accessToken,
        uid: get(profileResponse, "id"),
        provider: authResponse.graphDomain,
      });

      try {
        const result = await omniauthLoginMutation(user);
        const data = get(result, "data.omniauthLogin");

        if (data.success) {
          router.push({ name: 'Dashboard' })
        } else {
        }
      } catch (error) {}
    };
    const OnFacebookAuthFail = (authErrorResponse) => {
      createToast(authErrorResponse, { type: "danger" });
    };

    const handleGoogleClickLogin = async () => {
      try {
        const googleUser = await googleAuth.signIn();
        if (!googleUser) {
          return null;
        }

        let profile = googleUser.getBasicProfile();

        const user = {
          provider: googleUser.getAuthResponse().idpId,
          uid: profile.getId(),
          name: profile.getName(),
          email: profile.getEmail(),
          accessToken: googleUser.getAuthResponse().access_token,
        }
        const result = await omniauthLoginMutation(user);
        const data = get(result, "data.omniauthLogin");

        if (data.success) {
          createToast('Login Success', {type: 'success'})
          router.push({ name: 'Dashboard' })
        }
      } catch (error) {
      }
    }

    return {
      OnFacebookAuthSuccess,
      OnFacebookAuthFail,
      handleGoogleClickLogin
    };
  },
};
</script>
