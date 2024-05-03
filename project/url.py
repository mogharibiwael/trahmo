from django.urls import path
from . import views
from . import api
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
    path('',views.show_tabraa,name='show_tabraa'),
    # category
    path('category',views.category,name='category'),
    path('add-category',views.add_category,name='add_category'),
    path('show-category',views.show_category,name='show_category'),
    # path('/delete-category/<int:id>',views.index,name='add_category'),
    path('state',views.state,name='state'),
    path('add-state',views.add_state,name='add_state'),
    path('show-state',views.show_state,name='show_state'),
    path('api/get_category',api.get_category,name='get_category'),
    path('api/get_state',api.get_state,name='get_state'),
    path('api/get_state_details/<int:id>',api.get_state_details),
    path('edit_state/<int:id>',views.edit_state,name='edit_state'),
    path('delete_state/<int:id>',views.delete_state,name='delete_state'),

    # benficiary
    path('benficiary',views.benficiary,name='benficiary'),
    path('add-benficiary',views.add_benficiary,name='add_benficiary'),
    path('show-benficiary',views.show_benficiary,name='show_benficiary'),
    # tabraa
    path('tabraa',views.tabraa,name='tabraa'),
    path('show-tabraa',views.show_tabraa,name='show_tabraa'),
    path('api/send_tabraa',api.send_tabraa,name='send_tabraa'),
    path('api/tabraat_page',views.show_tabraa_page,name='tabraat_page'),
    path('api/get_done_tabraa',views.get_done_tabraa,name='get_done_tabraa'),
    path('api/get_not_done_tabraa',views.get_not_done_tabraa,name='get_not_done_tabraa'),
    path('api/tabraa_details/<int:id>',views.get_tabraa_details,name='tabraa_details'),
    path('api/add_state_from_app',api.add_state_from_app,name='add_state_frome_app'),
    path('api/activate_state/<int:id>',views.activate_state,name='activate_state'),
    path('api/state_from_app',views.state_from_app,name='state_from_app'),
    path('api/state_from_app_details/<int:id>',views.state_from_app_details,name='state_from_app_details'),

    #category with producr 
    path('api/get_category_with_state',api.get_category_with_state,name='get_category_with_state'),
    path('api/get_state_by_category/<int:id>',api.get_state_by_category,name='get_category_with_state'),







]+ static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
