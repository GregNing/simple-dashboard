<template>
  <div class="row">
    <div class="col-md-6 offset-md-3">
    <h2>ResetPassword</h2>
    <form @submit.prevent="onSubmit">
      <custom-input
        label="OldPassword"
        v-model="oldpassword"
        type="password"
        name="oldpassword"
        :error="errors.oldpassword"
        class-object="form-floating mb-3"
      />
      <custom-input
        label="Password"
        v-model="password"
        type="password"
        name="password"
        :error="errors.password"
        class-object="form-floating mb-3"
      />
      <custom-input
        label="PasswordConfirmation"
        v-model="passwordConfirmation"
        type="password"
        name="passwordConfirmation"
        :error="errors.passwordConfirmation"
        class-object="form-floating mb-3"
      />
      <button class="btn btn-primary btn-lg" :disabled="!meta.valid">Reset New Password</button>
    </form>
      <div class="text-sm text-muted">
        <router-link :to="{ name: 'LogIn' }">LogIn</router-link>
      </div>
      <div class="text-sm text-muted">
        <router-link :to="{ name: 'SignUp' }">SignUp</router-link>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { ResetPassword } from '@/graphql/Queries/User'
import CustomInput from '@/components/Shared/CustomInput.vue'
import { ResetPasswordSchema } from '@/components/Schema/Index'
import { useMutation } from '@vue/apollo-composable'
import { createToast } from 'mosha-vue-toastify'
import { useField, useForm } from 'vee-validate'
import { useRoute, useRouter } from 'vue-router'
import { get, merge } from 'lodash'

export default {
  name: 'ResetPassword',
  components: {
    "custom-input": CustomInput,
  },
  setup() {
    const route = useRoute()
    const router = useRouter()
    const { handleSubmit, meta, errors } = useForm({ validationSchema: ResetPasswordSchema })
    const { value: password } = useField('password')
    const { value: passwordConfirmation } = useField('passwordConfirmation')
    const { value: oldpassword } = useField('oldpassword')
    const { mutate: resetPasswordMutation } = useMutation(ResetPassword)
    const onSubmit = handleSubmit(async values => {
      try {
        let result = await resetPasswordMutation(values)
        let data = get(result, 'data.resetPassword')

        if (data.success) {
          createToast('Success reset password', {type: 'success'})
          router.push({ name: 'Dashboard' })
        }
      } catch (error) {
      }
    });
    return {
      password,
      passwordConfirmation,
      oldpassword,
      meta,
      errors,
      onSubmit,
    }
  },
};
</script>
