import { object, string } from 'yup'

export const SignUpFormSchema = object().shape({
  email: string()
    .email()
    .required(),
  password: string().min(5).required(),
  name: string().required().min(8),
});