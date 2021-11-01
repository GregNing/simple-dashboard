<template>
  <div class="row">
    <div class="col-md-6 offset-md-3">
    <h2>ForgotPassword</h2>
    <form @submit.prevent="onSubmit">
      <custom-input
        label="Email"
        v-model="email"
        type="email"
        name="email"
        :error="errors.email"
        class-object="form-floating mb-3"
        placeholder="name@example.com"
      />
      <button class="btn btn-primary btn-lg" :disabled="!meta.valid">Send password reset email</button>
    </form>
    </div>
  </div>
</template>

<script lang="ts">
import { ForgotPassword } from '@/graphql/Queries/User'
import CustomInput from '@/components/Shared/CustomInput.vue'
import { EmailSchema } from '@/components/Schema/Index'
import { useMutation } from '@vue/apollo-composable'
import { createToast } from 'mosha-vue-toastify'
import { useField, useForm } from 'vee-validate'
import { useRouter } from 'vue-router'
import { get } from 'lodash'

export default {
  name: 'ForgotPassword',
  components: {
    "custom-input": CustomInput,
  },
  setup() {
    const router = useRouter()
    const { handleSubmit, meta, errors } = useForm({ validationSchema: EmailSchema })
    const { value: email } = useField('email');
    const { mutate: forgotPasswordMutation, loading: loading } = useMutation(ForgotPassword)

    const onSubmit = handleSubmit(async values => {
      try {
        let result = await forgotPasswordMutation(values)
        let data = get(result, 'data.forgotPassword')

        if (data.success) {
          createToast('Emali already Send!', {type: 'success'})
          router.push({ name: 'LogIn' })
        }
      } catch (error) {
      }
    })

    return {
      email,
      meta,
      errors,
      onSubmit,
    }
  },
};
</script>
