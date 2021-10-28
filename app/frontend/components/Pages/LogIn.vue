<template>
  <div class="row">
    <div class="col-md-6 offset-md-3">
      <h2>LogIn</h2>
      <form @submit.prevent="onSubmit">
        <custom-input
          label="email"
          v-model="email"
          type="email"
          name="email"
          :error="errors.email"
          class-object="form-floating mb-3"
          placeholder="name@example.com"
        />
        <custom-input
          label="password"
          v-model="password"
          type="password"
          name="password"
          :error="errors.password"
          class-object="form-floating mb-3"
          placeholder="123456"
        />
        <button class="btn btn-primary btn-lg" :disabled="!meta.valid" >SignIn</button>
      </form>
    </div>
  </div>
</template>
<script lang="ts">
import CustomInput from '@/components/Shared/CustomInput.vue'
import { useField, useForm } from 'vee-validate'
import { useMutation } from '@vue/apollo-composable'
import { SignInFormSchema } from '@/components/Schema/Index'
import { LogIn } from '@/graphql/Queries/User'
import _get from 'lodash/get'
import { createToast } from 'mosha-vue-toastify'
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'

export default {
  name: 'LogIn',
  components: { "custom-input": CustomInput },
  setup() {
    const router = useRouter()
    const { dispatch } = useStore()
    const { handleSubmit, meta, errors } = useForm({ validationSchema: SignInFormSchema });
    const { value: email } = useField('email')
    const { value: password } = useField('password')

    const { mutate: logInMutation } = useMutation(LogIn, () => ({ fetchPolicy: 'no-cache'}))
    const onSubmit = handleSubmit(async values =>{
      try {
        let result = await logInMutation(values)
        let data = _get(result, 'data.logIn')

        if (data.success) {
          dispatch('setAuthToken', data.user.authenticationToken)
          dispatch('setUser', data.user)
          createToast('LogIn Success', {type: 'success'})
          router.push({ name: 'Dashboard' })
        }
      } catch (error) {
      }
    })

    return {
      errors,
      email,
      password,
      meta,
      onSubmit
    }
  }
};
</script>
