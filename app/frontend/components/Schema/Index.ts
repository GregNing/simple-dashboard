import { object, string } from 'yup'

export const SignUpFormSchema = object().shape({
  email: string()
    .email()
    .required(),
  password: string().required().matches(
    /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})/,
    "Must Contain 8 Characters, One Uppercase, One Lowercase, One Number and One Special Case Character"
  ),
  name: string().required().min(6),
});