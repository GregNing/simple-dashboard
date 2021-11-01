import gql from 'graphql-tag'

export const RegisterUser = gql`
  mutation registerUser(
    $email: String!,
    $name: String!,
    $password: String!,
  ) {
    registerUser(input: {
      email: $email,
      name: $name,
      password: $password,
    }) {
      success
      errors
    }
  }
`

export const OmniauthLogin = gql`
  mutation omniauthLogin(
    $provider: String!,
    $uid: String!,
    $name: String!,
    $email: String!,
    $accessToken: String!,
  ) {
    omniauthLogin(input:
      {
        omniauthAttributes: {
          provider: $provider
          uid: $uid
          name: $name
          email: $email
          accessToken: $accessToken
        }
      }
    ) {
      user {
        id
        name
        email
        authenticationToken
      }
      success
      errors
    }
  }
`

export const LogIn = gql`
  mutation logIn($email: String!, $password: String!) {
    logIn(input: { email: $email, password: $password }) {
      user {
        id
        name
        authenticationToken
      }
      success
      errors
    }
  }
`
export const LogOut = gql`
  mutation logOut {
    logOut(input: {}) {
      success
      errors
    }
  }
`

export const ForgotPassword = gql`
  mutation forgotPassword($email: String!) {
    forgotPassword(input: { email: $email }) {
      success
      errors
    }
  }
`;

export const UpdatePasswordWithToken = gql`
  mutation updatePasswordWithToken($reset_password_token: String!, $password: String!, $passwordConfirmation: String!) {
    updatePasswordWithToken(input: {
      resetPasswordToken: $reset_password_token,
      password: $password,
      passwordConfirmation: $passwordConfirmation }) {
        success
        errors
    }
  }
`;

export const ResetPassword = gql`
  mutation resetPassword($oldpassword: String!, $password: String!, $passwordConfirmation: String!) {
    resetPassword(input: {
      oldpassword: $oldpassword,
      password: $password,
      passwordConfirmation: $passwordConfirmation }) {
        success
        errors
    }
  }
`;
