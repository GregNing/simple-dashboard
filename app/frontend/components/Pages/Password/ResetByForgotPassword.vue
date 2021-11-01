<template>
  <div class="row">
    <div class="col-md-6 offset-md-3">
    <h2>ResetPassword</h2>
    <form @submit.prevent="onSubmit">
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
import { UpdatePasswordWithToken } from '@/graphql/Queries/User'
import CustomInput from '@/components/Shared/CustomInput.vue'
import { ForgotPasswordSchema } from '@/components/Schema/Index'
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
    const { handleSubmit, meta, errors } = useForm({ validationSchema: ForgotPasswordSchema })
    const { value: password } = useField('password')
    const { value: passwordConfirmation } = useField('passwordConfirmation')
    const { mutate: updatePasswordWithTokenMutation } = useMutation(UpdatePasswordWithToken)
    const onSubmit = handleSubmit(async values => {
      try {
        let result = await updatePasswordWithTokenMutation(merge(values, {reset_password_token: route.query.token}))
        let data = get(result, 'data.updatePasswordWithToken')

        if (data.success) {
          createToast('Success reset password', {type: 'success'})
          router.push({ name: 'LogIn' })
        }
      } catch (error) {
      }
    });
    return {
      password,
      passwordConfirmation,
      meta,
      errors,
      onSubmit,
    }
  },
};
</script>
