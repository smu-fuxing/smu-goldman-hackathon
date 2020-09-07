import Amplify, {Auth} from 'aws-amplify'

const store = require('store')

Amplify.configure({
  Auth: {
    region: 'ap-southeast-1' || process.env.AWS_REGION,
    userPoolId: 'ap-southeast-1_2qJL1PEJ5' || process.env.AWS_COGNITO_USER_POOL_ID,
    userPoolWebClientId: '17fj8oj4ekni3jjhol58k27fph' || process.env.AWS_COGNITO_USER_POOL_WEB_CLIENT_ID,
  }
});

export default function (context, inject) {
  inject('amplify', {
    Auth: Auth,
    signIn(username, password) {
      return Auth.signIn({
        username, password
      }).then((user) => {
        store.set('mavis.user', user)
        return user
      })
    },
    signUp(username, password) {
      return this.Auth.signUp({
        username, password
      }).then(({user}) => {
        store.set('mavis.user', user)
        return user
      })
    },
    async signOut() {
      store.remove('mavis.user')
    },
    getUser() {
      return store.get('mavis.user')
    }
  })
}
