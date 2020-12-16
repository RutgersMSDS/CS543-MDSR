from django.urls import path
from . import views
from django.conf.urls import url
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    url(r'^$', views.hi, name='home-page'),
    url(r'^introduction/$', views.intro, name='introduction'),
    url(r'^reference/$', views.ref, name='reference'),
    url(r'^home/$', views.home, name='home'),
    url(r'^minJ/$', views.minJ, name='minJ'),
    url(r'^maxJ/$', views.maxJ, name='maxJ'),
    url(r'^meanJ/$', views.meanJ, name='meanJ'),
    url(r'^minJh/$', views.minJh, name='minJh'),
    url(r'^maxJh/$', views.maxJh, name='maxJh'),
    url(r'^meanJh/$', views.meanJh, name='meanJh'),

    url(r'^minK/$', views.minK, name='minK'),
    url(r'^maxK/$', views.maxK, name='maxK'),
    url(r'^meanK/$', views.meanK, name='meanK'),
    url(r'^minKh/$', views.minKh, name='minKh'),
    url(r'^maxKh/$', views.maxKh, name='maxKh'),
    url(r'^meanKh/$', views.meanKh, name='meanKh'),

    url(r'^nstar/$', views.nstar, name='nstar'),
    url(r'^nstarh/$', views.nstarh, name='nstarh'),
    url(r'^bDist/$', views.bDist, name='bDist'),
    url(r'^searchbar/$', views.searchbar, name='searchbar'),
    url(r'^graphWaves/$', views.graphWaves, name='graphWaves'),
    url(r'^searchbar2/$', views.searchbar2, name='searchbar2'),
    url(r'^generalJ/$', views.generalJ, name='generalJ'),
    url(r'^generalK/$', views.generalK, name='generalK'),
    url(r'^generalN/$', views.generalN, name='generalN'),

    path('cities', views.getGraphCities),
    path('graphs', views.getGraphImages)

]

urlpatterns += staticfiles_urlpatterns()
#urlpatterns += static("/graphWaves" + settings.STATIC_URL, document_root=settings.STATIC_ROOT)

print(urlpatterns)