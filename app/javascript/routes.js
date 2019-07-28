import VueRouter from 'vue-router';
import AppPage from './app.vue';
import PostFormView from './components/PostFormView.vue';
import PostPreviewModal from './components/PostPreviewModal.vue';

const routes = [
{
  path: '/back/posts/:id/edit', 
  component: PostFormView,
  name: 'PostEditView',
},
{
  path: '/back/posts/new', 
  component: PostFormView,
  name: 'PostNewView'
},
// {
//   path: '*',
//   redirect: '/back/posts/:id/edit'
// }
]

export default new VueRouter({ mode: 'history', routes });