import VueRouter from 'vue-router';
import AppPage from './app.vue';
import PostEditView from './components/PostEditView.vue';

const routes = [
{
  path: '/back/posts/:id/edit', 
  component: PostEditView,
  name: 'PostEditView'
},
]

export default new VueRouter({ mode: 'history', routes });