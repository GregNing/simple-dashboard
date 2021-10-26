export default {
  beforeMount(el: any, binding: any, vnode: any) {
    CheckComponentMethods()
    const appId = binding.value
    const facebookSignInAPI = document.createElement('script')
    facebookSignInAPI.setAttribute('src', '//connect.facebook.net/en_US/sdk.js')
    document.head.appendChild(facebookSignInAPI)

    facebookSignInAPI.onload = InitFacebookButton

    function InitFacebookButton() {
      FB.init({
        appId,
        xfbml: true,
        version: 'v11.0',
        status: true
      })
    }

    el.addEventListener('click', PopUp)

    function PopUp() {
      FB.login(
        function (facebookResponse: any) {
          if (facebookResponse.status === 'connected') {
            FB.api('/me?fields=id,name,email,picture', function (response: any) {
              OnSuccess(facebookResponse.authResponse, response)
            })
          } else {
            Onfail()
          }
        },
        { scope: 'public_profile,email', return_scopes: true }
      )
    }
    function OnSuccess(facebookAuthResponse: any, facebookProfileResponse: any) {
      binding.instance.OnFacebookAuthSuccess(
        facebookAuthResponse,
        facebookProfileResponse
      )
    }
    function Onfail() {
      binding.instance.OnFacebookAuthFail('Facebook sign-in failed')
    }
    function CheckComponentMethods() {
      if (!binding.instance.OnFacebookAuthSuccess) {
        throw new Error(
          'The method OnFacebookAuthSuccess must be defined on the component'
        )
      }

      if (!binding.instance.OnFacebookAuthFail) {
        throw new Error(
          'The method OnFacebookAuthFail must be defined on the component'
        )
      }
    }
  }
}
