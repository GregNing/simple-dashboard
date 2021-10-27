<template>
  <div :class="[ 'form-group', !!error && 'has-error', classObject ]">
    <input
      :id="name"
      :name="name"
      :type="type"
      :value="modelValue"
      @input="$emit('update:modelValue', $event.target.value)"
      :class="{ 'is-invalid' : !!error, 'form-control': true }"
      :placeholder="placeholder"
    />
    <label class="form-label" :for="name">{{ label}}</label>
    <div class="invalid-feedback" v-if="!!error"> {{ error }} </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  props: {
    label: String,
    modelValue: String,
    type: { required: true },
    name: { required: true },
    error: String,
    classObject: String,
    placeholder: String
  },
})
</script>
