import VueRouter from 'vue-router';
import AppPage from './app.vue';
import PostFormView from './components/PostFormView.vue';

const routes = [
{
  path: '/back/posts/:id/edit', 
  component: PostFormView,
  name: 'PostEditView'
},
{
  path: '/back/posts/new', 
  component: PostFormView,
  name: 'PostNewView'
},

]

export default new VueRouter({ mode: 'history', routes });