from pelican import signals
from pelican.contents import Article, Draft, Page
from pelican.generators import ArticlesGenerator
from pelican.utils import path_to_url
from bs4 import BeautifulSoup
import os


def images_extraction(instance, siteurl):
    representativeImage = None
    if type(instance) in (Article, Draft, Page):
        if 'image' in instance.metadata:
            representativeImage = instance.get_relative_source_path(os.path.join(instance.relative_dir, instance.metadata['image']))

        # Process Summary:
        # If summary contains images, extract one to be the representativeImage and remove images from summary
        soup = BeautifulSoup(instance.summary, 'html.parser')
        images = soup.find_all('img')
        for i in images:
            if not representativeImage:
                representativeImage = i['src']
            i.extract()
        if len(images) > 0:
            # set _summary field which is based on metadata. summary field is only based on article's content and not settable
            try:
              instance._summary = unicode(soup)
            except NameError: # for python3
              instance._summary = str(soup)

        # If there are no image in summary, look for it in the content body
        if not representativeImage:
            soup = BeautifulSoup(instance.content, 'html.parser')
            imageTag = soup.find('img')
            if imageTag:
                representativeImage = imageTag['src']

        # Set the attribute to content instance
        instance.featured_image = representativeImage


def run_plugin(generators):
    for generator in generators:
        if isinstance(generator, ArticlesGenerator):
            for article in generator.articles:
                images_extraction(article, siteurl=generator.settings['SITEURL'])


def register():
    try:
        signals.all_generators_finalized.connect(run_plugin)
    except AttributeError:
        # NOTE: This results in #314 so shouldn't really be relied on
        # https://github.com/getpelican/pelican-plugins/issues/314
        signals.content_object_init.connect(images_extraction)
