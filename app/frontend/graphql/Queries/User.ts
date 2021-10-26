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
