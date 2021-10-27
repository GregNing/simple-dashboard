<template>
  <div class="row">
    <div class="col-md-6 offset-md-3">
      <h2>Sign up</h2>
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
          label="name"
          type="text"
          name="name"
          v-model="name"
          :error="errors.name"
          class-object="form-floating mb-3"
          placeholder="Greg"
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
        <button class="btn btn-primary btn-lg" :disabled="!meta.valid" >SignUp</button>
      </form>
    </div>
  </div>
</template>
<script lang="ts">
import CustomInput from '@/components/Shared/CustomInput.vue'
import { useField, useForm } from 'vee-validate'
import { useMutation } from '@vue/apollo-composable'
import { SignUpFormSchema } from '@/components/Schema/Index'
import { RegisterUser } from '@/graphql/Queries/User'
import _get from 'lodash/get'
import { createToast } from 'mosha-vue-toastify'

export default {
  name: 'SignUp',
  components: { "custom-input": CustomInput },
  setup() {
    const { handleSubmit, meta, errors } = useForm({ validationSchema: SignUpFormSchema });
    const { value: email } = useField('email')
    const { value: password } = useField('password')
    const { value: name } = useField('name')

    const { mutate: signUpMutation, loading: loading } = useMutation(RegisterUser, () => ({ fetchPolicy: 'no-cache'}))
    const onSubmit = handleSubmit(async values =>{
      try {
        let result = await signUpMutation(values)
        let data = _get(result, 'data.registerUser')

        if (data.success) {
          createToast('SignUp Success', {type: 'success'})
        }
      } catch (error) {
      }
    })

    return {
      errors,
      email,
      password,
      meta,
      name,
      onSubmit
    }
  }
};
</script>
